const aws = @import("aws");

const OptionStatus = @import("option_status.zig").OptionStatus;

/// Status of the advanced options for the specified Elasticsearch domain.
/// Currently, the following advanced options are available:
///
/// * Option to allow references to indices in an HTTP request body. Must be
///   `false` when configuring access to individual sub-resources. By default,
///   the value is `true`.
/// See [Configuration Advanced
/// Options](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-createupdatedomains.html#es-createdomain-configure-advanced-options) for more information.
///
/// * Option to specify the percentage of heap space that is allocated to field
///   data. By default, this setting is unbounded.
///
/// For more information, see [Configuring Advanced
/// Options](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-createupdatedomains.html#es-createdomain-configure-advanced-options).
pub const AdvancedOptionsStatus = struct {
    /// Specifies the status of advanced options for the specified Elasticsearch
    /// domain.
    options: []const aws.map.StringMapEntry,

    /// Specifies the status of `OptionStatus` for advanced options for the
    /// specified Elasticsearch domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
