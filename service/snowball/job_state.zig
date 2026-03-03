const std = @import("std");

pub const JobState = enum {
    new,
    preparing_appliance,
    preparing_shipment,
    in_transit_to_customer,
    with_customer,
    in_transit_to_aws,
    with_aws_sorting_facility,
    with_aws,
    in_progress,
    complete,
    cancelled,
    listing,
    pending,

    pub const json_field_names = .{
        .new = "New",
        .preparing_appliance = "PreparingAppliance",
        .preparing_shipment = "PreparingShipment",
        .in_transit_to_customer = "InTransitToCustomer",
        .with_customer = "WithCustomer",
        .in_transit_to_aws = "InTransitToAWS",
        .with_aws_sorting_facility = "WithAWSSortingFacility",
        .with_aws = "WithAWS",
        .in_progress = "InProgress",
        .complete = "Complete",
        .cancelled = "Cancelled",
        .listing = "Listing",
        .pending = "Pending",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .new => "New",
            .preparing_appliance => "PreparingAppliance",
            .preparing_shipment => "PreparingShipment",
            .in_transit_to_customer => "InTransitToCustomer",
            .with_customer => "WithCustomer",
            .in_transit_to_aws => "InTransitToAWS",
            .with_aws_sorting_facility => "WithAWSSortingFacility",
            .with_aws => "WithAWS",
            .in_progress => "InProgress",
            .complete => "Complete",
            .cancelled => "Cancelled",
            .listing => "Listing",
            .pending => "Pending",
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
