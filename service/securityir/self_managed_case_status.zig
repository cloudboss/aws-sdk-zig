const std = @import("std");

pub const SelfManagedCaseStatus = enum {
    submitted,
    detection_and_analysis,
    containment_eradication_and_recovery,
    post_incident_activities,

    pub const json_field_names = .{
        .submitted = "Submitted",
        .detection_and_analysis = "Detection and Analysis",
        .containment_eradication_and_recovery = "Containment, Eradication and Recovery",
        .post_incident_activities = "Post-incident Activities",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitted => "Submitted",
            .detection_and_analysis => "Detection and Analysis",
            .containment_eradication_and_recovery => "Containment, Eradication and Recovery",
            .post_incident_activities => "Post-incident Activities",
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
