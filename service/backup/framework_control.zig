const ControlInputParameter = @import("control_input_parameter.zig").ControlInputParameter;
const ControlScope = @import("control_scope.zig").ControlScope;

/// Contains detailed information about all of the controls of a framework. Each
/// framework
/// must contain at least one control.
pub const FrameworkControl = struct {
    /// The name/value pairs.
    control_input_parameters: ?[]const ControlInputParameter = null,

    /// The name of a control. This name is between 1 and 256 characters.
    control_name: []const u8,

    /// The scope of a control. The control scope defines what the control will
    /// evaluate. Three
    /// examples of control scopes are: a specific backup plan, all backup plans
    /// with a specific
    /// tag, or all backup plans.
    ///
    /// For more information, see [
    /// `ControlScope`.](https://docs.aws.amazon.com/aws-backup/latest/devguide/API_ControlScope.html)
    control_scope: ?ControlScope = null,

    pub const json_field_names = .{
        .control_input_parameters = "ControlInputParameters",
        .control_name = "ControlName",
        .control_scope = "ControlScope",
    };
};
