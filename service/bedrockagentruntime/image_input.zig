const ImageInputFormat = @import("image_input_format.zig").ImageInputFormat;
const ImageInputSource = @import("image_input_source.zig").ImageInputSource;

/// Details about an image in the result from a function in the action group
/// invocation. You can specify images only when the function is a computer use
/// action. For more information, see [Configure an Amazon Bedrock Agent to
/// complete tasks with computer use
/// tools](https://docs.aws.amazon.com/bedrock/latest/userguide/agent-computer-use.html).
pub const ImageInput = struct {
    /// The type of image in the result.
    format: ImageInputFormat,

    /// The source of the image in the result.
    source: ImageInputSource,

    pub const json_field_names = .{
        .format = "format",
        .source = "source",
    };
};
