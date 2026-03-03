const std = @import("std");

pub const MalaysiaServiceTaxCode = enum {
    consultancy,
    digital_svc_electronic_medium,
    it_services,
    training_or_coaching,

    pub const json_field_names = .{
        .consultancy = "Consultancy",
        .digital_svc_electronic_medium = "Digital Service And Electronic Medium",
        .it_services = "IT Services",
        .training_or_coaching = "Training Or Coaching",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .consultancy => "Consultancy",
            .digital_svc_electronic_medium => "Digital Service And Electronic Medium",
            .it_services => "IT Services",
            .training_or_coaching => "Training Or Coaching",
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
