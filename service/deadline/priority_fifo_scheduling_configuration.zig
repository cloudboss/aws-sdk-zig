/// Configuration for priority first-in, first-out (FIFO) scheduling. Workers
/// are assigned to the highest-priority job first. When multiple jobs share the
/// same priority, the job submitted earliest receives workers first.
pub const PriorityFifoSchedulingConfiguration = struct {
};
