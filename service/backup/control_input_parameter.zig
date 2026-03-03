/// The parameters for a control. A control can have zero, one, or more than one
/// parameter. An example of a control with two parameters is: "backup plan
/// frequency is at
/// least `daily` and the retention period is at least `1 year`". The
/// first parameter is `daily`. The second parameter is `1 year`.
pub const ControlInputParameter = struct {
    /// The name of a parameter, for example, `BackupPlanFrequency`.
    parameter_name: ?[]const u8 = null,

    /// The value of parameter, for example, `hourly`.
    parameter_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .parameter_name = "ParameterName",
        .parameter_value = "ParameterValue",
    };
};
