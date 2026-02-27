/// Information regarding UpdateBrokerCount.
pub const BrokerCountUpdateInfo = struct {
    /// Kafka Broker IDs of brokers being created.
    created_broker_ids: ?[]const f64,

    /// Kafka Broker IDs of brokers being deleted.
    deleted_broker_ids: ?[]const f64,

    pub const json_field_names = .{
        .created_broker_ids = "CreatedBrokerIds",
        .deleted_broker_ids = "DeletedBrokerIds",
    };
};
