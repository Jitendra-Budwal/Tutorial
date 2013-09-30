package guestbook;

import java.util.Date;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.google.common.base.Joiner;
import com.googlecode.objectify.ObjectifyFactory;

@Entity
public class Transactions implements Comparable<Transactions> {

	static {
		 ObjectifyService.register(Transactions.class);
	}
	// id is set by the datastore for us
	@Id
	public Long id;
	@Index Key<Stream> stream;
	@Index public Date transactionTime;
	
	// TODO: figure out why this is needed
	@SuppressWarnings("unused")
	private Transactions() {
	}
	
	@Override
	public String toString() {
		Joiner joiner = Joiner.on(":");
		return joiner.join(this.getClass(), id.toString(), transactionTime.toString());
 	}

	public Transactions(Long id, Key<Stream> stream) {
		this.id = id;
		this.stream = stream;
		this.transactionTime = new Date();
	}

	@Override
	public int compareTo(Transactions other) {
		if (transactionTime.after(other.transactionTime)) {
			return 1;
		} else if (transactionTime.before(other.transactionTime)) {
			return -1;
		}
		return 0;
	}
}
