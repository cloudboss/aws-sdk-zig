const AIBenchmarkJobStatus = @import("ai_benchmark_job_status.zig").AIBenchmarkJobStatus;

/// Summary information about an AI benchmark job.
pub const AIBenchmarkJobSummary = struct {
    /// The Amazon Resource Name (ARN) of the benchmark job.
    ai_benchmark_job_arn: []const u8,

    /// The name of the benchmark job.
    ai_benchmark_job_name: []const u8,

    /// The status of the benchmark job.
    ai_benchmark_job_status: AIBenchmarkJobStatus,

    /// The name of the AI workload configuration used by the benchmark job.
    ai_workload_config_name: ?[]const u8 = null,

    /// A timestamp that indicates when the benchmark job was created.
    creation_time: i64,

    /// A timestamp that indicates when the benchmark job completed.
    end_time: ?i64 = null,

    pub const json_field_names = .{
        .ai_benchmark_job_arn = "AIBenchmarkJobArn",
        .ai_benchmark_job_name = "AIBenchmarkJobName",
        .ai_benchmark_job_status = "AIBenchmarkJobStatus",
        .ai_workload_config_name = "AIWorkloadConfigName",
        .creation_time = "CreationTime",
        .end_time = "EndTime",
    };
};
