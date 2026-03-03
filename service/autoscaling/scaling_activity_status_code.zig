const std = @import("std");

pub const ScalingActivityStatusCode = enum {
    pending_spot_bid_placement,
    waiting_for_spot_instance_request_id,
    waiting_for_spot_instance_id,
    waiting_for_instance_id,
    pre_in_service,
    in_progress,
    waiting_for_elb_connection_draining,
    mid_lifecycle_action,
    waiting_for_instance_warmup,
    successful,
    failed,
    cancelled,
    waiting_for_connection_draining,
    waiting_for_in_place_update_to_start,
    waiting_for_in_place_update_to_finalize,
    in_place_update_in_progress,

    pub const json_field_names = .{
        .pending_spot_bid_placement = "PendingSpotBidPlacement",
        .waiting_for_spot_instance_request_id = "WaitingForSpotInstanceRequestId",
        .waiting_for_spot_instance_id = "WaitingForSpotInstanceId",
        .waiting_for_instance_id = "WaitingForInstanceId",
        .pre_in_service = "PreInService",
        .in_progress = "InProgress",
        .waiting_for_elb_connection_draining = "WaitingForELBConnectionDraining",
        .mid_lifecycle_action = "MidLifecycleAction",
        .waiting_for_instance_warmup = "WaitingForInstanceWarmup",
        .successful = "Successful",
        .failed = "Failed",
        .cancelled = "Cancelled",
        .waiting_for_connection_draining = "WaitingForConnectionDraining",
        .waiting_for_in_place_update_to_start = "WaitingForInPlaceUpdateToStart",
        .waiting_for_in_place_update_to_finalize = "WaitingForInPlaceUpdateToFinalize",
        .in_place_update_in_progress = "InPlaceUpdateInProgress",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_spot_bid_placement => "PendingSpotBidPlacement",
            .waiting_for_spot_instance_request_id => "WaitingForSpotInstanceRequestId",
            .waiting_for_spot_instance_id => "WaitingForSpotInstanceId",
            .waiting_for_instance_id => "WaitingForInstanceId",
            .pre_in_service => "PreInService",
            .in_progress => "InProgress",
            .waiting_for_elb_connection_draining => "WaitingForELBConnectionDraining",
            .mid_lifecycle_action => "MidLifecycleAction",
            .waiting_for_instance_warmup => "WaitingForInstanceWarmup",
            .successful => "Successful",
            .failed => "Failed",
            .cancelled => "Cancelled",
            .waiting_for_connection_draining => "WaitingForConnectionDraining",
            .waiting_for_in_place_update_to_start => "WaitingForInPlaceUpdateToStart",
            .waiting_for_in_place_update_to_finalize => "WaitingForInPlaceUpdateToFinalize",
            .in_place_update_in_progress => "InPlaceUpdateInProgress",
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
