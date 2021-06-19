const title = "I Gotta Feeling";

function pause() {
  //no return
}

function isPlaying() {
  return true;
}

function getTitle() {
  return title;
}

function getDuration() {
  return 289.0;
}

function addAlbums(albums: string[]) {
  postMessage("Albums added!");
  return albums;
}

export const test = (a = true) => {
  return "";
};

export const test2 = (b = "hi") => {
  return 1;
};
