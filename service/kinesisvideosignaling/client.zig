const aws = @import("aws");
const std = @import("std");

const get_ice_server_config = @import("get_ice_server_config.zig");
const send_alexa_offer_to_master = @import("send_alexa_offer_to_master.zig");
const CallOptions = @import("call_options.zig").CallOptions;

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Kinesis Video Signaling";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Gets the Interactive Connectivity Establishment (ICE) server configuration
    /// information, including URIs, username, and password which can be used to
    /// configure the
    /// WebRTC connection. The ICE component uses this configuration information to
    /// setup the
    /// WebRTC connection, including authenticating with the Traversal Using Relays
    /// around NAT
    /// (TURN) relay server.
    ///
    /// TURN is a protocol that is used to improve the connectivity of peer-to-peer
    /// applications. By providing a cloud-based relay service, TURN ensures that a
    /// connection
    /// can be established even when one or more peers are incapable of a direct
    /// peer-to-peer
    /// connection. For more information, see [A REST API For
    /// Access To TURN
    /// Services](https://tools.ietf.org/html/draft-uberti-rtcweb-turn-rest-00).
    ///
    /// You can invoke this API to establish a fallback mechanism in case either of
    /// the peers
    /// is unable to establish a direct peer-to-peer connection over a signaling
    /// channel. You
    /// must specify either a signaling channel ARN or the client ID in order to
    /// invoke this
    /// API.
    pub fn getIceServerConfig(self: *Self, allocator: std.mem.Allocator, input: get_ice_server_config.GetIceServerConfigInput, options: CallOptions) !get_ice_server_config.GetIceServerConfigOutput {
        return get_ice_server_config.execute(self, allocator, input, options);
    }

    /// This API allows you to connect WebRTC-enabled devices with Alexa display
    /// devices. When
    /// invoked, it sends the Alexa Session Description Protocol (SDP) offer to the
    /// master peer.
    /// The offer is delivered as soon as the master is connected to the specified
    /// signaling
    /// channel. This API returns the SDP answer from the connected master. If the
    /// master is not
    /// connected to the signaling channel, redelivery requests are made until the
    /// message
    /// expires.
    pub fn sendAlexaOfferToMaster(self: *Self, allocator: std.mem.Allocator, input: send_alexa_offer_to_master.SendAlexaOfferToMasterInput, options: CallOptions) !send_alexa_offer_to_master.SendAlexaOfferToMasterOutput {
        return send_alexa_offer_to_master.execute(self, allocator, input, options);
    }
};
