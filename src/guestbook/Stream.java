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
public class Stream implements Comparable<Stream> {

	static {
		 ObjectifyService.register(Stream.class);
	}
	// id is set by the datastore for us
	@Id
	public Long id;
	public String name;
	public String owner;
	public Long imageCount;
	public Long viewCount;
	public String tags;
	@Index public Date changeDate;
	@Index public Date createDate;
	public String coverImageUrl;
  
	// TODO: figure out why this is needed
	@SuppressWarnings("unused")
	private Stream() {
	}
	
	@Override
	public String toString() {
		Joiner joiner = Joiner.on(":");
		return joiner.join(id.toString(), name, owner, imageCount, tags, createDate.toString());
 	}

//	public Stream(String name, String tags, String coverImageUrl) {
//		this.name = name;
//		this.tags = tags;
//		this.coverImageUrl = coverImageUrl;
//		this.createDate = new Date();
//	}
//
	public Stream(String name, String tags, String coverImageUrl, String owner, Long imageCount, Long viewCount) {
		this.name = name;
		this.tags = tags;
		this.coverImageUrl = coverImageUrl;
		this.owner = owner;
		this.imageCount = imageCount;
		this.viewCount = viewCount;
		this.createDate = new Date();
	}

	public void setChangeDate() {
		changeDate = new Date();
	}

	public Key<Stream> getKey() {
		return Key.create(Stream.class, this.id);
	}
	
	public void incViewCount() {
		viewCount++;
	}

	public void incCount() {
		imageCount++;
		setChangeDate();
	}

	@Override
	public int compareTo(Stream other) {
		if (createDate.after(other.createDate)) {
			return 1;
		} else if (createDate.before(other.createDate)) {
			return -1;
		}
		return 0;
	}
}
