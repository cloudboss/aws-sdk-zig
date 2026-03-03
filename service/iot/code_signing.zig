const CustomCodeSigning = @import("custom_code_signing.zig").CustomCodeSigning;
const StartSigningJobParameter = @import("start_signing_job_parameter.zig").StartSigningJobParameter;

/// Describes the method to use when code signing a file.
pub const CodeSigning = struct {
    /// The ID of the `AWSSignerJob` which was created to sign the file.
    aws_signer_job_id: ?[]const u8 = null,

    /// A custom method for code signing a file.
    custom_code_signing: ?CustomCodeSigning = null,

    /// Describes the code-signing job.
    start_signing_job_parameter: ?StartSigningJobParameter = null,

    pub const json_field_names = .{
        .aws_signer_job_id = "awsSignerJobId",
        .custom_code_signing = "customCodeSigning",
        .start_signing_job_parameter = "startSigningJobParameter",
    };
};
