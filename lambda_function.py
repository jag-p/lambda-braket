from braket.aws import AwsDevice
from braket.circuits import Circuit

def handler(event, context):
    device = AwsDevice("arn:aws:braket:::device/quantum-simulator/amazon/sv1")
    bell = Circuit().h(0).cnot(0, 1)
    print(bell)

    task = device.run(bell, shots=100)
    return task.result().measurement_counts