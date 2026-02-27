const EnvironmentState = @import("environment_state.zig").EnvironmentState;
const CheckResult = @import("check_result.zig").CheckResult;
const VcfVersion = @import("vcf_version.zig").VcfVersion;

/// A list of environments with summarized environment details.
pub const EnvironmentSummary = struct {
    /// The date and time that the environment was created.
    created_at: ?i64,

    /// The Amazon Resource Name (ARN) that is associated with the environment.
    environment_arn: ?[]const u8,

    /// A unique ID for the environment.
    environment_id: ?[]const u8,

    /// The name of the environment.
    environment_name: ?[]const u8,

    /// The state of an environment.
    environment_state: ?EnvironmentState,

    /// Reports impaired functionality that stems from issues internal to the
    /// environment, such as impaired reachability.
    environment_status: ?CheckResult,

    /// The date and time that the environment was modified.
    modified_at: ?i64,

    /// The VCF version of the environment.
    vcf_version: ?VcfVersion,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .environment_arn = "environmentArn",
        .environment_id = "environmentId",
        .environment_name = "environmentName",
        .environment_state = "environmentState",
        .environment_status = "environmentStatus",
        .modified_at = "modifiedAt",
        .vcf_version = "vcfVersion",
    };
};
