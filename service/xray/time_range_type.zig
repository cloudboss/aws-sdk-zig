const std = @import("std");

pub const TimeRangeType = enum {
    trace_id,
    event,
    service,
    TraceId,
    Event,
    Service,

    pub const json_field_names = .{
        .trace_id = "TraceId",
        .event = "Event",
        .service = "Service",
        .TraceId = "TraceId",
        .Event = "Event",
        .Service = "Service",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .trace_id, .TraceId => "TraceId",
            .event, .Event => "Event",
            .service, .Service => "Service",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        if (std.mem.eql(u8, str, "TraceId")) return .trace_id;
        if (std.mem.eql(u8, str, "Event")) return .event;
        if (std.mem.eql(u8, str, "Service")) return .service;

        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
