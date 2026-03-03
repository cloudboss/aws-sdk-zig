const OperatingSystem = @import("operating_system.zig").OperatingSystem;

/// Defines the basic information about a patch baseline.
pub const PatchBaselineIdentity = struct {
    /// The description of the patch baseline.
    baseline_description: ?[]const u8 = null,

    /// The ID of the patch baseline.
    baseline_id: ?[]const u8 = null,

    /// The name of the patch baseline.
    baseline_name: ?[]const u8 = null,

    /// Indicates whether this is the default baseline. Amazon Web Services Systems
    /// Manager supports creating multiple default
    /// patch baselines. For example, you can create a default patch baseline for
    /// each operating
    /// system.
    default_baseline: bool = false,

    /// Defines the operating system the patch baseline applies to. The default
    /// value is
    /// `WINDOWS`.
    operating_system: ?OperatingSystem = null,

    pub const json_field_names = .{
        .baseline_description = "BaselineDescription",
        .baseline_id = "BaselineId",
        .baseline_name = "BaselineName",
        .default_baseline = "DefaultBaseline",
        .operating_system = "OperatingSystem",
    };
};
