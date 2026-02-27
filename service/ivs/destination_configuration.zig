const S3DestinationConfiguration = @import("s3_destination_configuration.zig").S3DestinationConfiguration;

/// A complex type that describes a location where recorded videos will be
/// stored. Each member
/// represents a type of destination configuration. For recording, you define
/// one and only one
/// type of destination configuration.
pub const DestinationConfiguration = struct {
    /// An S3 destination configuration where recorded videos will be stored.
    s_3: ?S3DestinationConfiguration,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
