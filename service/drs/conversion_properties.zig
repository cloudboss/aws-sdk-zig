const aws = @import("aws");

const ProductCode = @import("product_code.zig").ProductCode;

/// Properties of a conversion job
pub const ConversionProperties = struct {
    /// The timestamp of when the snapshot being converted was taken
    data_timestamp: ?[]const u8 = null,

    /// Whether the volume being converted uses UEFI or not
    force_uefi: ?bool = null,

    /// The root volume name of a conversion job
    root_volume_name: ?[]const u8 = null,

    /// A mapping between the volumes being converted and the converted snapshot ids
    volume_to_conversion_map: ?[]const aws.map.MapEntry([]const aws.map.StringMapEntry) = null,

    /// A mapping between the volumes being converted and the product codes
    /// associated with them
    volume_to_product_codes: ?[]const aws.map.MapEntry([]const ProductCode) = null,

    /// A mapping between the volumes and their sizes
    volume_to_volume_size: ?[]const aws.map.MapEntry(i64) = null,

    pub const json_field_names = .{
        .data_timestamp = "dataTimestamp",
        .force_uefi = "forceUefi",
        .root_volume_name = "rootVolumeName",
        .volume_to_conversion_map = "volumeToConversionMap",
        .volume_to_product_codes = "volumeToProductCodes",
        .volume_to_volume_size = "volumeToVolumeSize",
    };
};
