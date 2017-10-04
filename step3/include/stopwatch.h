#ifndef stopwatch_h
#define stopwatch_h
//----------------------------------------------------------------------
#include <vector>
#include <fstream>
#include <algorithm>
#include <mpi.h>
//----------------------------------------------------------------------
class StopWatch {
private:
  std::vector<double> data;
  double current_time;
  const char *basename;
  int id;
public:
  StopWatch(int rank, const char* bname) {
    basename = bname;
    id = rank;
  };
  ~StopWatch(void) {
    //if (id == 0)SaveToFile();
    //SaveToFile();
  }
  void Start(void) {
    current_time = Communicator::GetTime();
  };
  void Stop(void) {
    data.push_back(Communicator::GetTime() - current_time);
  };

  void SaveToFile(void) {
    std::vector<double> recvbuf;
    char filename[256];
    sprintf(filename, "%s%05d.dat", basename, id);
    std::ofstream ofs(filename);
    ofs.write((const char *)&data[0], sizeof(double)*data.size());
  };

  double Duration(void) const {
    return data.back();
  }

  double DurationMean(const int cnt) const {
    return std::accumulate(data.rbegin(), data.rbegin() + cnt, 0.0);
  }
};
//----------------------------------------------------------------------
#ifdef GPU_OACC

#include <cuda_runtime.h> // to use cudaEventRecord
#include <helper_cuda.h>  // to use checkCudaErrors

class TimerGPU {
  std::vector<double> data;
  cudaEvent_t start, stop;

public:
  TimerGPU() {
    checkCudaErrors(cudaEventCreate(&start));
    checkCudaErrors(cudaEventCreate(&stop));
  }

  ~TimerGPU() {
    checkCudaErrors(cudaEventDestroy(start));
    checkCudaErrors(cudaEventDestroy(stop));
  }

  void Start() {
    checkCudaErrors(cudaEventRecord(start));
  }

  void Stop() {
    checkCudaErrors(cudaEventRecord(stop));
  }

  void Record() {
    checkCudaErrors(cudaEventSynchronize(stop));
    float elapsed_time = 0.0;
    checkCudaErrors(cudaEventElapsedTime(&elapsed_time, start, stop));
    data.push_back(elapsed_time * 1.0e-3);
  }

  double Duration(void) const {
    return data.back();
  }

  double DurationMean(const int cnt) const {
    return std::accumulate(data.rbegin(), data.rbegin() + cnt, 0.0);
  }
};

#endif
//----------------------------------------------------------------------
#endif
