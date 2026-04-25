const std = @import("std");

/// The filter name for filtering notify templates. The available filter names
/// are:
///
/// * `channels`: Filter by channels.
/// * `language-code`: Filter by language code.
/// * `supported-countries`: Filter by supported countries.
/// * `supported-voice-ids`: Filter by supported voice IDs.
/// * `template-type`: Filter by template type.
/// * `tier-access`: Filter by tier access.
pub const NotifyTemplateFilterName = enum {
    template_type,
    channels,
    tier_access,
    supported_countries,
    language_code,
    supported_voice_ids,

    pub const json_field_names = .{
        .template_type = "template-type",
        .channels = "channels",
        .tier_access = "tier-access",
        .supported_countries = "supported-countries",
        .language_code = "language-code",
        .supported_voice_ids = "supported-voice-ids",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .template_type => "template-type",
            .channels => "channels",
            .tier_access => "tier-access",
            .supported_countries => "supported-countries",
            .language_code => "language-code",
            .supported_voice_ids => "supported-voice-ids",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
