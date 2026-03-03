const CompressionType = @import("compression_type.zig").CompressionType;
const TrainingInputMode = @import("training_input_mode.zig").TrainingInputMode;

/// Defines a named input source, called a channel, to be used by an algorithm.
pub const ChannelSpecification = struct {
    /// A brief description of the channel.
    description: ?[]const u8 = null,

    /// Indicates whether the channel is required by the algorithm.
    is_required: ?bool = null,

    /// The name of the channel.
    name: []const u8,

    /// The allowed compression types, if data compression is used.
    supported_compression_types: ?[]const CompressionType = null,

    /// The supported MIME types for the data.
    supported_content_types: []const []const u8,

    /// The allowed input mode, either FILE or PIPE.
    ///
    /// In FILE mode, Amazon SageMaker copies the data from the input source onto
    /// the local Amazon Elastic Block Store (Amazon EBS) volumes before starting
    /// your training algorithm. This is the most commonly used input mode.
    ///
    /// In PIPE mode, Amazon SageMaker streams input data from the source directly
    /// to your algorithm without using the EBS volume.
    supported_input_modes: []const TrainingInputMode,

    pub const json_field_names = .{
        .description = "Description",
        .is_required = "IsRequired",
        .name = "Name",
        .supported_compression_types = "SupportedCompressionTypes",
        .supported_content_types = "SupportedContentTypes",
        .supported_input_modes = "SupportedInputModes",
    };
};
