const std = @import("std");

pub const Tier = enum {
    custom,
    default,
    dot_net_core,
    dot_net_worker,
    dot_net_web_tier,
    dot_net_web,
    sql_server,
    sql_server_alwayson_availability_group,
    mysql,
    postgresql,
    java_jmx,
    oracle,
    sap_hana_multi_node,
    sap_hana_single_node,
    sap_hana_high_availability,
    sap_ase_single_node,
    sap_ase_high_availability,
    sql_server_failover_cluster_instance,
    sharepoint,
    active_directory,
    sap_netweaver_standard,
    sap_netweaver_distributed,
    sap_netweaver_high_availability,

    pub const json_field_names = .{
        .custom = "CUSTOM",
        .default = "DEFAULT",
        .dot_net_core = "DOT_NET_CORE",
        .dot_net_worker = "DOT_NET_WORKER",
        .dot_net_web_tier = "DOT_NET_WEB_TIER",
        .dot_net_web = "DOT_NET_WEB",
        .sql_server = "SQL_SERVER",
        .sql_server_alwayson_availability_group = "SQL_SERVER_ALWAYSON_AVAILABILITY_GROUP",
        .mysql = "MYSQL",
        .postgresql = "POSTGRESQL",
        .java_jmx = "JAVA_JMX",
        .oracle = "ORACLE",
        .sap_hana_multi_node = "SAP_HANA_MULTI_NODE",
        .sap_hana_single_node = "SAP_HANA_SINGLE_NODE",
        .sap_hana_high_availability = "SAP_HANA_HIGH_AVAILABILITY",
        .sap_ase_single_node = "SAP_ASE_SINGLE_NODE",
        .sap_ase_high_availability = "SAP_ASE_HIGH_AVAILABILITY",
        .sql_server_failover_cluster_instance = "SQL_SERVER_FAILOVER_CLUSTER_INSTANCE",
        .sharepoint = "SHAREPOINT",
        .active_directory = "ACTIVE_DIRECTORY",
        .sap_netweaver_standard = "SAP_NETWEAVER_STANDARD",
        .sap_netweaver_distributed = "SAP_NETWEAVER_DISTRIBUTED",
        .sap_netweaver_high_availability = "SAP_NETWEAVER_HIGH_AVAILABILITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .custom => "CUSTOM",
            .default => "DEFAULT",
            .dot_net_core => "DOT_NET_CORE",
            .dot_net_worker => "DOT_NET_WORKER",
            .dot_net_web_tier => "DOT_NET_WEB_TIER",
            .dot_net_web => "DOT_NET_WEB",
            .sql_server => "SQL_SERVER",
            .sql_server_alwayson_availability_group => "SQL_SERVER_ALWAYSON_AVAILABILITY_GROUP",
            .mysql => "MYSQL",
            .postgresql => "POSTGRESQL",
            .java_jmx => "JAVA_JMX",
            .oracle => "ORACLE",
            .sap_hana_multi_node => "SAP_HANA_MULTI_NODE",
            .sap_hana_single_node => "SAP_HANA_SINGLE_NODE",
            .sap_hana_high_availability => "SAP_HANA_HIGH_AVAILABILITY",
            .sap_ase_single_node => "SAP_ASE_SINGLE_NODE",
            .sap_ase_high_availability => "SAP_ASE_HIGH_AVAILABILITY",
            .sql_server_failover_cluster_instance => "SQL_SERVER_FAILOVER_CLUSTER_INSTANCE",
            .sharepoint => "SHAREPOINT",
            .active_directory => "ACTIVE_DIRECTORY",
            .sap_netweaver_standard => "SAP_NETWEAVER_STANDARD",
            .sap_netweaver_distributed => "SAP_NETWEAVER_DISTRIBUTED",
            .sap_netweaver_high_availability => "SAP_NETWEAVER_HIGH_AVAILABILITY",
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
