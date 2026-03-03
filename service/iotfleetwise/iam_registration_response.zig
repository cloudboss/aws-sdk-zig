const RegistrationStatus = @import("registration_status.zig").RegistrationStatus;

/// Information about registering an Identity and Access Management (IAM)
/// resource so Amazon Web Services IoT FleetWise edge agent
/// software can transfer your vehicle data to Amazon Timestream.
pub const IamRegistrationResponse = struct {
    /// A message associated with a registration error.
    error_message: ?[]const u8 = null,

    /// The status of registering your IAM resource. The status can be one of
    /// `REGISTRATION_SUCCESS`, `REGISTRATION_PENDING`,
    /// `REGISTRATION_FAILURE`.
    registration_status: RegistrationStatus,

    /// The Amazon Resource Name (ARN) of the IAM role to register.
    role_arn: []const u8,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .registration_status = "registrationStatus",
        .role_arn = "roleArn",
    };
};
