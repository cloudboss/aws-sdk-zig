const Architecture = @import("architecture.zig").Architecture;
const BuildState = @import("build_state.zig").BuildState;
const Chipset = @import("chipset.zig").Chipset;

/// Contains summary information about a MicroVM image build.
pub const MicrovmImageBuildSummary = struct {
    /// The target CPU architecture for the build. Supported value: ARM_64.
    architecture: Architecture,

    /// The build request ID.
    build_id: []const u8,

    /// The current state of the build.
    build_state: BuildState,

    /// The target chipset for the build.
    chipset: Chipset,

    /// The target chipset generation for the build.
    chipset_generation: []const u8,

    /// The timestamp when the build was created.
    created_at: i64,

    /// The ARN of the MicroVM image.
    image_arn: []const u8,

    /// The version of the MicroVM image.
    image_version: []const u8,

    /// The reason for the build state, if applicable.
    state_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .architecture = "architecture",
        .build_id = "buildId",
        .build_state = "buildState",
        .chipset = "chipset",
        .chipset_generation = "chipsetGeneration",
        .created_at = "createdAt",
        .image_arn = "imageArn",
        .image_version = "imageVersion",
        .state_reason = "stateReason",
    };
};
