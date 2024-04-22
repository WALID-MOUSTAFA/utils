#include <iostream>
#include <stdint.h>
#include "WalidLazyAF.h"
#include <time.h>

class MyApp : public WalidLazyAF
{

public:

	MyApp(std::string win_title, int win_w, int win_h )
		:WalidLazyAF(win_title, win_w, win_h)
	{} 
	
	bool
	onInit() override
	{
		SDL_SetRenderDrawColor(this->renderer, 0, 0, 0x7f, 255);
		SDL_RenderClear(this->renderer);
		return true;
	}

	bool
	onUpdate(double elpasedTime) override
	{
		int w, h;
		SDL_GetWindowSize(this->window, &w, &h);
		SDL_RenderClear(this->renderer);

		return true;
	}	
};



int
main(int argc, char** argv)
{

	MyApp mp("My-window", 700, 600);
	mp.start();
	return 0;
}

