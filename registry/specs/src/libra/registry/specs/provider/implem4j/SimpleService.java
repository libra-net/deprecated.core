package libra.registry.specs.provider.implem4j;

import libra.itf.SimpleSample;

public class SimpleService implements SimpleSample {

	@Override
	public String printHello() {
		return "Hello World";
	}

	@Override
	public void doSomething() {
		// Nothing to do
	}

	@Override
	public String printSingleArg() {
		// TODO Auto-generated method stub
		return null;
	}

}
