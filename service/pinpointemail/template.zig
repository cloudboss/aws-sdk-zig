pub const Template = struct {
    /// The Amazon Resource Name (ARN) of the template.
    template_arn: ?[]const u8,

    /// An object that defines the values to use for message variables in the
    /// template. This object is a set of key-value pairs. Each key defines a
    /// message variable in the template. The corresponding value defines the value
    /// to use for that variable.
    template_data: ?[]const u8,

    pub const json_field_names = .{
        .template_arn = "TemplateArn",
        .template_data = "TemplateData",
    };
};
