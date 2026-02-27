const PreferredChannelPipeline = @import("preferred_channel_pipeline.zig").PreferredChannelPipeline;
const MultiplexProgramServiceDescriptor = @import("multiplex_program_service_descriptor.zig").MultiplexProgramServiceDescriptor;
const MultiplexVideoSettings = @import("multiplex_video_settings.zig").MultiplexVideoSettings;

/// Multiplex Program settings configuration.
pub const MultiplexProgramSettings = struct {
    /// Indicates which pipeline is preferred by the multiplex for program ingest.
    preferred_channel_pipeline: ?PreferredChannelPipeline,

    /// Unique program number.
    program_number: i32,

    /// Transport stream service descriptor configuration for the Multiplex program.
    service_descriptor: ?MultiplexProgramServiceDescriptor,

    /// Program video settings configuration.
    video_settings: ?MultiplexVideoSettings,

    pub const json_field_names = .{
        .preferred_channel_pipeline = "PreferredChannelPipeline",
        .program_number = "ProgramNumber",
        .service_descriptor = "ServiceDescriptor",
        .video_settings = "VideoSettings",
    };
};
