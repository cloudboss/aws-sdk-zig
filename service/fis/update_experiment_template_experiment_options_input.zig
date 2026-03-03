const EmptyTargetResolutionMode = @import("empty_target_resolution_mode.zig").EmptyTargetResolutionMode;

/// Specifies an experiment option for an experiment template.
pub const UpdateExperimentTemplateExperimentOptionsInput = struct {
    /// The empty target resolution mode of the experiment template.
    empty_target_resolution_mode: ?EmptyTargetResolutionMode = null,

    pub const json_field_names = .{
        .empty_target_resolution_mode = "emptyTargetResolutionMode",
    };
};
