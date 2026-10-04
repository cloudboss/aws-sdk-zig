const std = @import("std");

pub const ConnectorConfigProvider = enum {
    eks_anywhere,
    anthos,
    gke,
    aks,
    openshift,
    tanzu,
    rancher,
    ec2,
    other,

    pub const json_field_names = .{
        .eks_anywhere = "EKS_ANYWHERE",
        .anthos = "ANTHOS",
        .gke = "GKE",
        .aks = "AKS",
        .openshift = "OPENSHIFT",
        .tanzu = "TANZU",
        .rancher = "RANCHER",
        .ec2 = "EC2",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .eks_anywhere => "EKS_ANYWHERE",
            .anthos => "ANTHOS",
            .gke => "GKE",
            .aks => "AKS",
            .openshift => "OPENSHIFT",
            .tanzu => "TANZU",
            .rancher => "RANCHER",
            .ec2 => "EC2",
            .other => "OTHER",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
