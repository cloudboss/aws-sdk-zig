const Control = @import("control.zig").Control;

/// A set of controls in Audit Manager.
pub const ControlSet = struct {
    /// The list of controls within the control set.
    controls: ?[]const Control,

    /// The identifier of the control set in the assessment. This is the control set
    /// name in a
    /// plain string format.
    id: ?[]const u8,

    /// The name of the control set.
    name: ?[]const u8,

    pub const json_field_names = .{
        .controls = "controls",
        .id = "id",
        .name = "name",
    };
};
