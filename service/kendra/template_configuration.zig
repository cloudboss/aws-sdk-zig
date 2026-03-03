/// Provides a template for the configuration information to connect to your
/// data
/// source.
pub const TemplateConfiguration = struct {
    /// The template schema used for the data source, where templates schemas are
    /// supported.
    ///
    /// See [Data source
    /// template
    /// schemas](https://docs.aws.amazon.com/kendra/latest/dg/ds-schemas.html).
    template: ?[]const u8 = null,

    pub const json_field_names = .{
        .template = "Template",
    };
};
