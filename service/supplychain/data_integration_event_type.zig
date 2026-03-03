const std = @import("std");

pub const DataIntegrationEventType = enum {
    forecast,
    inventory_level,
    inbound_order,
    inbound_order_line,
    inbound_order_line_schedule,
    outbound_order_line,
    outbound_shipment,
    process_header,
    process_operation,
    process_product,
    reservation,
    shipment,
    shipment_stop,
    shipment_stop_order,
    supply_plan,
    dataset,

    pub const json_field_names = .{
        .forecast = "scn.data.forecast",
        .inventory_level = "scn.data.inventorylevel",
        .inbound_order = "scn.data.inboundorder",
        .inbound_order_line = "scn.data.inboundorderline",
        .inbound_order_line_schedule = "scn.data.inboundorderlineschedule",
        .outbound_order_line = "scn.data.outboundorderline",
        .outbound_shipment = "scn.data.outboundshipment",
        .process_header = "scn.data.processheader",
        .process_operation = "scn.data.processoperation",
        .process_product = "scn.data.processproduct",
        .reservation = "scn.data.reservation",
        .shipment = "scn.data.shipment",
        .shipment_stop = "scn.data.shipmentstop",
        .shipment_stop_order = "scn.data.shipmentstoporder",
        .supply_plan = "scn.data.supplyplan",
        .dataset = "scn.data.dataset",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .forecast => "scn.data.forecast",
            .inventory_level => "scn.data.inventorylevel",
            .inbound_order => "scn.data.inboundorder",
            .inbound_order_line => "scn.data.inboundorderline",
            .inbound_order_line_schedule => "scn.data.inboundorderlineschedule",
            .outbound_order_line => "scn.data.outboundorderline",
            .outbound_shipment => "scn.data.outboundshipment",
            .process_header => "scn.data.processheader",
            .process_operation => "scn.data.processoperation",
            .process_product => "scn.data.processproduct",
            .reservation => "scn.data.reservation",
            .shipment => "scn.data.shipment",
            .shipment_stop => "scn.data.shipmentstop",
            .shipment_stop_order => "scn.data.shipmentstoporder",
            .supply_plan => "scn.data.supplyplan",
            .dataset => "scn.data.dataset",
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
