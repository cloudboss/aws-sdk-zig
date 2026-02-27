const ProtectedJobOutput = @import("protected_job_output.zig").ProtectedJobOutput;

/// Details about the job results.
pub const ProtectedJobResult = struct {
    /// The output of the protected job.
    output: ProtectedJobOutput,

    pub const json_field_names = .{
        .output = "output",
    };
};
