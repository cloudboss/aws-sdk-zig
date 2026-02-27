pub const StreamingExperiencePreferredProtocolEnum = enum {
    tcp,
    udp,

    pub const json_field_names = .{
        .tcp = "TCP",
        .udp = "UDP",
    };
};
