/// Configuration for runtime validation of imported images. This structure
/// specifies the instance type to use for testing the imported image's
/// streaming capabilities.
pub const RuntimeValidationConfig = struct {
    /// The instance type to use for runtime validation testing. It's recommended to
    /// use the same instance type you plan to use for your fleet to ensure accurate
    /// validation results.
    intended_instance_type: ?[]const u8,

    pub const json_field_names = .{
        .intended_instance_type = "IntendedInstanceType",
    };
};
