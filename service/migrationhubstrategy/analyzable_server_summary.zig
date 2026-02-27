/// Summary information about an analyzable server.
pub const AnalyzableServerSummary = struct {
    /// The host name of the analyzable server.
    hostname: ?[]const u8,

    /// The ip address of the analyzable server.
    ip_address: ?[]const u8,

    /// The data source of the analyzable server.
    source: ?[]const u8,

    /// The virtual machine id of the analyzable server.
    vm_id: ?[]const u8,

    pub const json_field_names = .{
        .hostname = "hostname",
        .ip_address = "ipAddress",
        .source = "source",
        .vm_id = "vmId",
    };
};
