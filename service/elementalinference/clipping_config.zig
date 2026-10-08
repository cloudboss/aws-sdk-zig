const DataSourceConfiguration = @import("data_source_configuration.zig").DataSourceConfiguration;

/// A type of OutputConfig, used when the output in a feed is for the clip
/// feature.
pub const ClippingConfig = struct {
    /// A string that you want Elemental Inference to always include in the event
    /// clipping metadata for this output. The string might identify the sports
    /// event in the source media, for example.
    callback_metadata: ?[]const u8 = null,

    /// The data source to map onto this clipping output. This parameter is
    /// optional. When you include this parameter, Elemental Inference reads the
    /// event data for the fixture that you specify, and includes that data in the
    /// event clipping metadata for this output.
    ///
    /// If you omit this parameter, Elemental Inference doesn't map a data source
    /// onto this output.
    data_source_configuration: ?DataSourceConfiguration = null,

    pub const json_field_names = .{
        .callback_metadata = "callbackMetadata",
        .data_source_configuration = "dataSourceConfiguration",
    };
};
