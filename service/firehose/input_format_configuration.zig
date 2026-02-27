const Deserializer = @import("deserializer.zig").Deserializer;

/// Specifies the deserializer you want to use to convert the format of the
/// input data.
/// This parameter is required if `Enabled` is set to true.
pub const InputFormatConfiguration = struct {
    /// Specifies which deserializer to use. You can choose either the Apache Hive
    /// JSON SerDe
    /// or the OpenX JSON SerDe. If both are non-null, the server rejects the
    /// request.
    deserializer: ?Deserializer,

    pub const json_field_names = .{
        .deserializer = "Deserializer",
    };
};
