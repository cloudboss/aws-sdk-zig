/// Specifies the default alarm state.
/// The configuration applies to all alarms that were created based on this
/// alarm model.
pub const InitializationConfiguration = struct {
    /// The value must be `TRUE` or `FALSE`. If `FALSE`, all
    /// alarm instances created based on the alarm model are activated. The default
    /// value is
    /// `TRUE`.
    disabled_on_initialization: bool,

    pub const json_field_names = .{
        .disabled_on_initialization = "disabledOnInitialization",
    };
};
