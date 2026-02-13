const ParameterType = @import("parameter_type.zig").ParameterType;

/// An Amazon Web Services Systems Manager parameter in Parameter Store.
pub const Parameter = struct {
    /// The Amazon Resource Name (ARN) of the parameter.
    arn: ?[]const u8,

    /// The data type of the parameter, such as `text` or `aws:ec2:image`. The
    /// default is `text`.
    data_type: ?[]const u8,

    /// Date the parameter was last changed or updated and the parameter version was
    /// created.
    last_modified_date: ?i64,

    /// The name of the parameter.
    name: ?[]const u8,

    /// Either the version number or the label used to retrieve the parameter value.
    /// Specify
    /// selectors by using one of the following formats:
    ///
    /// parameter_name:version
    ///
    /// parameter_name:label
    selector: ?[]const u8,

    /// Applies to parameters that reference information in other Amazon Web
    /// Services services.
    /// `SourceResult` is the raw result or response from the source.
    source_result: ?[]const u8,

    /// The type of parameter. Valid values include the following: `String`,
    /// `StringList`, and `SecureString`.
    ///
    /// **Note:**
    ///
    /// If type is `StringList`, the system returns a comma-separated string with no
    /// spaces between commas in the `Value` field.
    @"type": ?ParameterType,

    /// The parameter value.
    ///
    /// **Note:**
    ///
    /// If type is `StringList`, the system returns a comma-separated string with no
    /// spaces between commas in the `Value` field.
    value: ?[]const u8,

    /// The parameter version.
    version: ?i64,

    pub const json_field_names = .{
        .arn = "ARN",
        .data_type = "DataType",
        .last_modified_date = "LastModifiedDate",
        .name = "Name",
        .selector = "Selector",
        .source_result = "SourceResult",
        .@"type" = "Type",
        .value = "Value",
        .version = "Version",
    };
};
