const aws = @import("aws");

const ImageGenerationDestinationConfig = @import("image_generation_destination_config.zig").ImageGenerationDestinationConfig;
const Format = @import("format.zig").Format;
const ImageSelectorType = @import("image_selector_type.zig").ImageSelectorType;
const ConfigurationStatus = @import("configuration_status.zig").ConfigurationStatus;

/// The structure that contains the information required for the KVS images
/// delivery. If null, the configuration will be deleted from the stream.
pub const ImageGenerationConfiguration = struct {
    /// The structure that contains the information required to deliver images to a
    /// customer.
    destination_config: ImageGenerationDestinationConfig,

    /// The accepted image format.
    format: Format,

    /// The list of a key-value pair structure that contains extra parameters that
    /// can be applied when the image is generated.
    /// The `FormatConfig` key is the `JPEGQuality`, which indicates the JPEG
    /// quality key to be used to generate the image.
    /// The `FormatConfig` value accepts ints from 1 to 100. If the value is 1, the
    /// image will be generated with less quality and the best compression.
    /// If the value is 100, the image will be generated with the best quality and
    /// less compression. If no value is provided, the default value of the
    /// `JPEGQuality`
    /// key will be set to 80.
    format_config: ?[]const aws.map.StringMapEntry = null,

    /// The height of the output image that is used in conjunction with the
    /// `WidthPixels` parameter. When both
    /// `HeightPixels` and `WidthPixels` parameters are provided, the image will be
    /// stretched to fit the specified aspect ratio.
    /// If only the `HeightPixels` parameter is provided, its original aspect ratio
    /// will be used to calculate the `WidthPixels` ratio.
    /// If neither parameter is provided, the original image size will be returned.
    height_pixels: ?i32 = null,

    /// The origin of the Server or Producer timestamps to use to generate the
    /// images.
    image_selector_type: ImageSelectorType,

    /// The time interval in milliseconds (ms) at which the images need to be
    /// generated from the stream. The minimum value that can be provided is 200 ms.
    /// If the timestamp range is less than the sampling interval, the
    /// Image from the `StartTimestamp` will be returned if available.
    sampling_interval: i32,

    /// Indicates whether the `ContinuousImageGenerationConfigurations` API is
    /// enabled or disabled.
    status: ConfigurationStatus,

    /// The width of the output image that is used in conjunction with the
    /// `HeightPixels` parameter. When both `WidthPixels` and
    /// `HeightPixels` parameters are provided, the image will be stretched to fit
    /// the specified aspect ratio. If only the `WidthPixels` parameter is
    /// provided, its original aspect ratio will be used to calculate the
    /// `HeightPixels` ratio. If neither parameter is provided, the original image
    /// size will be returned.
    width_pixels: ?i32 = null,

    pub const json_field_names = .{
        .destination_config = "DestinationConfig",
        .format = "Format",
        .format_config = "FormatConfig",
        .height_pixels = "HeightPixels",
        .image_selector_type = "ImageSelectorType",
        .sampling_interval = "SamplingInterval",
        .status = "Status",
        .width_pixels = "WidthPixels",
    };
};
