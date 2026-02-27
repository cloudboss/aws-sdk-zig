const ProtectedJobSingleMemberOutput = @import("protected_job_single_member_output.zig").ProtectedJobSingleMemberOutput;
const ProtectedJobS3Output = @import("protected_job_s3_output.zig").ProtectedJobS3Output;

/// Contains details about the protected job output.
pub const ProtectedJobOutput = union(enum) {
    /// The list of member Amazon Web Services account(s) that received the results
    /// of the job.
    member_list: ?[]const ProtectedJobSingleMemberOutput,
    /// If present, the output for a protected job with an `S3` output type.
    s_3: ?ProtectedJobS3Output,

    pub const json_field_names = .{
        .member_list = "memberList",
        .s_3 = "s3",
    };
};
