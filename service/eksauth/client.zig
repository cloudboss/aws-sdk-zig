const aws = @import("aws");
const std = @import("std");

const assume_role_for_pod_identity = @import("assume_role_for_pod_identity.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "EKS Auth";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// The Amazon EKS Auth API and the `AssumeRoleForPodIdentity` action are only
    /// used
    /// by the EKS Pod Identity Agent.
    ///
    /// We recommend that applications use the Amazon Web Services SDKs to connect
    /// to Amazon Web Services services; if
    /// credentials from an EKS Pod Identity association are available in the pod,
    /// the latest versions of the
    /// SDKs use them automatically.
    pub fn assumeRoleForPodIdentity(self: *Self, allocator: std.mem.Allocator, input: assume_role_for_pod_identity.AssumeRoleForPodIdentityInput, options: assume_role_for_pod_identity.Options) !assume_role_for_pod_identity.AssumeRoleForPodIdentityOutput {
        return assume_role_for_pod_identity.execute(self, allocator, input, options);
    }
};
