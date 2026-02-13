const aws = @import("aws");

/// Information about an Automation failure.
pub const FailureDetails = struct {
    /// Detailed information about the Automation step failure.
    details: ?[]const aws.map.MapEntry([]const []const u8),

    /// The stage of the Automation execution when the failure occurred. The stages
    /// include the
    /// following: InputValidation, PreVerification, Invocation, PostVerification.
    failure_stage: ?[]const u8,

    /// The type of Automation failure. Failure types include the following: Action,
    /// Permission,
    /// Throttling, Verification, Internal.
    failure_type: ?[]const u8,

    pub const json_field_names = .{
        .details = "Details",
        .failure_stage = "FailureStage",
        .failure_type = "FailureType",
    };
};
