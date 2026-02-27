const BuildtimeSettings = @import("buildtime_settings.zig").BuildtimeSettings;
const RuntimeSettings = @import("runtime_settings.zig").RuntimeSettings;

/// Contains specifications about the generative AI capabilities from Amazon
/// Bedrock that you can turn on for your bot.
pub const GenerativeAISettings = struct {
    buildtime_settings: ?BuildtimeSettings,

    runtime_settings: ?RuntimeSettings,

    pub const json_field_names = .{
        .buildtime_settings = "buildtimeSettings",
        .runtime_settings = "runtimeSettings",
    };
};
