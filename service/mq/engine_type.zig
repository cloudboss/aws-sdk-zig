/// The type of broker engine. Amazon MQ supports ActiveMQ and RabbitMQ.
pub const EngineType = enum {
    activemq,
    rabbitmq,

    pub const json_field_names = .{
        .activemq = "ACTIVEMQ",
        .rabbitmq = "RABBITMQ",
    };
};
