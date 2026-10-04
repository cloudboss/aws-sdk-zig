const std = @import("std");

/// Status of an enrichment job throughout its lifecycle.
///
/// Status progression: PENDING → RUNNING → {COMPLETED, FAILED, TIMED_OUT,
/// CANCELLED}
///
/// * PENDING: Job has been accepted and is waiting to start processing
///
/// * RUNNING: Job is actively processing video data to generate embeddings
///
/// * COMPLETED: Job finished successfully; embeddings are available in IoT
///   SiteWise
///
/// * FAILED: Job encountered an error during processing
///
/// * TIMED_OUT: Job exceeded the maximum processing time limit
///
/// * CANCELLED: Job was cancelled via CancelEnrichmentJob
///
/// Terminal states (job will not change status): COMPLETED, FAILED, TIMED_OUT,
/// CANCELLED
pub const EnrichmentJobStatus = enum {
    pending,
    running,
    completed,
    failed,
    timed_out,
    cancelled,

    pub const json_field_names = .{
        .pending = "PENDING",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .timed_out = "TIMED_OUT",
        .cancelled = "CANCELLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .running => "RUNNING",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .timed_out => "TIMED_OUT",
            .cancelled => "CANCELLED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
