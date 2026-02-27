const aws = @import("aws");

/// Information about a vehicle.
///
/// To return this information about vehicles in your account, you can use the
/// API operation.
pub const VehicleSummary = struct {
    /// The Amazon Resource Name (ARN) of the vehicle.
    arn: []const u8,

    /// Static information about a vehicle in a key-value pair. For example:
    ///
    /// `"engineType"` : `"1.3 L R2"`
    attributes: ?[]const aws.map.StringMapEntry,

    /// The time the vehicle was created in seconds since epoch (January 1, 1970 at
    /// midnight UTC time).
    creation_time: i64,

    /// The ARN of a decoder manifest associated with the vehicle.
    decoder_manifest_arn: []const u8,

    /// The time the vehicle was last updated in seconds since epoch (January 1,
    /// 1970 at midnight UTC time).
    last_modification_time: i64,

    /// The ARN of a vehicle model (model manifest) associated with the vehicle.
    model_manifest_arn: []const u8,

    /// The unique ID of the vehicle.
    vehicle_name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .attributes = "attributes",
        .creation_time = "creationTime",
        .decoder_manifest_arn = "decoderManifestArn",
        .last_modification_time = "lastModificationTime",
        .model_manifest_arn = "modelManifestArn",
        .vehicle_name = "vehicleName",
    };
};
