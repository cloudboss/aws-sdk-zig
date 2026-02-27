/// Represents the data binding configuration for a specific property using data
/// stored in
/// Amazon Web Services. For Amazon Web Services connected properties, you can
/// bind a property to
/// data stored in an Amplify DataStore model.
pub const FormInputBindingPropertiesValueProperties = struct {
    /// An Amplify DataStore model.
    model: ?[]const u8,

    pub const json_field_names = .{
        .model = "model",
    };
};
