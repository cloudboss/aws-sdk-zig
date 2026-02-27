const Configuration = @import("configuration.zig").Configuration;
const ExternalSource = @import("external_source.zig").ExternalSource;

/// The configuration information of the external data source.
pub const ExternalSourceConfiguration = struct {
    /// The configuration information of the external data source.
    configuration: Configuration,

    /// The type of the external data source.
    source: ExternalSource,

    pub const json_field_names = .{
        .configuration = "configuration",
        .source = "source",
    };
};
