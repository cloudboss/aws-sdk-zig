const std = @import("std");

pub const ExecutionBlockType = enum {
    custom_action_lambda,
    execution_approval,
    aurora,
    ec2_asg,
    routing_control,
    region_switch,
    parallel,
    ecs,
    eks_resource_scaling,
    route53_health_check,
    documentdb,
    rds_promote_read_replica,
    rds_create_cross_region_replica,
    lambda_event_source_mapping,
    aurora_serverless_scaling,
    aurora_provisioned_scaling,
    neptune,
    rds_switchover_read_replica,

    pub const json_field_names = .{
        .custom_action_lambda = "CustomActionLambda",
        .execution_approval = "ManualApproval",
        .aurora = "AuroraGlobalDatabase",
        .ec2_asg = "EC2AutoScaling",
        .routing_control = "ARCRoutingControl",
        .region_switch = "ARCRegionSwitchPlan",
        .parallel = "Parallel",
        .ecs = "ECSServiceScaling",
        .eks_resource_scaling = "EKSResourceScaling",
        .route53_health_check = "Route53HealthCheck",
        .documentdb = "DocumentDb",
        .rds_promote_read_replica = "RdsPromoteReadReplica",
        .rds_create_cross_region_replica = "RdsCreateCrossRegionReplica",
        .lambda_event_source_mapping = "LambdaEventSourceMapping",
        .aurora_serverless_scaling = "AuroraServerlessScaling",
        .aurora_provisioned_scaling = "AuroraProvisionedScaling",
        .neptune = "NeptuneGlobalDatabase",
        .rds_switchover_read_replica = "RdsSwitchoverReadReplica",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .custom_action_lambda => "CustomActionLambda",
            .execution_approval => "ManualApproval",
            .aurora => "AuroraGlobalDatabase",
            .ec2_asg => "EC2AutoScaling",
            .routing_control => "ARCRoutingControl",
            .region_switch => "ARCRegionSwitchPlan",
            .parallel => "Parallel",
            .ecs => "ECSServiceScaling",
            .eks_resource_scaling => "EKSResourceScaling",
            .route53_health_check => "Route53HealthCheck",
            .documentdb => "DocumentDb",
            .rds_promote_read_replica => "RdsPromoteReadReplica",
            .rds_create_cross_region_replica => "RdsCreateCrossRegionReplica",
            .lambda_event_source_mapping => "LambdaEventSourceMapping",
            .aurora_serverless_scaling => "AuroraServerlessScaling",
            .aurora_provisioned_scaling => "AuroraProvisionedScaling",
            .neptune => "NeptuneGlobalDatabase",
            .rds_switchover_read_replica => "RdsSwitchoverReadReplica",
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
