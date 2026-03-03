const std = @import("std");

/// Determines the sensitivity level for voice activity detection (VAD) in noisy
/// environments. This setting helps optimize speech recognition accuracy by
/// adjusting how the system responds to background noise.
///
/// Valid values include:
///
/// * `Default` - Standard sensitivity level suitable for most environments
///
/// * `HighNoiseTolerance` - Increased tolerance for moderate background noise
///
/// * `MaximumNoiseTolerance` - Maximum tolerance for high levels of background
///   noise
pub const SpeechDetectionSensitivity = enum {
    default,
    high_noise_tolerance,
    maximum_noise_tolerance,

    pub const json_field_names = .{
        .default = "Default",
        .high_noise_tolerance = "HighNoiseTolerance",
        .maximum_noise_tolerance = "MaximumNoiseTolerance",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "Default",
            .high_noise_tolerance => "HighNoiseTolerance",
            .maximum_noise_tolerance => "MaximumNoiseTolerance",
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
