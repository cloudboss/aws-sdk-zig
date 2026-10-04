/// A name-value pair that identifies the resource or attribute that a
/// `ControlError` applies to.
pub const ErrorScope = struct {
    /// The name of the resource field the error applies to (for example,
    /// `AMI_ID`, `FILE_PATH`, or `PACKAGE_NAME`).
    name: ?[]const u8 = null,

    /// The value of the resource field the error applies to.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
